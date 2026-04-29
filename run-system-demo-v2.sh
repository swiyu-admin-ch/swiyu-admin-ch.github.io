#!/usr/bin/env bash
set -euo pipefail

# System Demo Script
# This script demonstrates the full flow of:
# 1. Getting identifier information for a business partner
# 2. Generating and uploading a DID log
# 3. Getting proof of possession challenge
# 4. Creating and uploading proof of possession

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check dependencies
check_dependencies() {
    local missing_deps=0

    if ! command -v curl &> /dev/null; then
        log_error "curl is not installed"
        missing_deps=1
    fi

    if ! command -v jq &> /dev/null; then
        log_error "jq is not installed. Please install jq for JSON parsing."
        missing_deps=1
    fi

    if ! command -v java &> /dev/null; then
        log_error "java is not installed"
        missing_deps=1
    fi

    if [[ ! -f "didtoolbox-1.3.1-jar-with-dependencies.jar" ]]; then
        log_error "didtoolbox-1.3.1-jar-with-dependencies.jar not found in current directory"
        missing_deps=1
    fi

    if [[ ! -f "../proof-of-possession/create-pop.sh" ]]; then
        log_error "../proof-of-possession/create-pop.sh not found"
        missing_deps=1
    fi

    if [[ $missing_deps -eq 1 ]]; then
        exit 1
    fi
}

# Configuration
IDENTIFIER_API_URL="https://identifier-reg-api-a.trust-infra.swiyu-int.admin.ch"
IDENTIFIER_URL="https://identifier-reg-a.trust-infra.swiyu-int.admin.ch"
TRUST_API_URL="https://trust-reg-api-a.trust-infra.swiyu-int.admin.ch"

log_info "Checking dependencies..."
check_dependencies
log_success "All dependencies found"

echo ""
log_info "Please provide the following information:"
echo ""

# Prompt for SWIYU_PARTNER_ID
read -p "Enter your SWIYU Partner ID: " SWIYU_PARTNER_ID
if [[ -z "$SWIYU_PARTNER_ID" ]]; then
    log_error "SWIYU_PARTNER_ID cannot be empty"
    exit 1
fi

# Prompt for TOKEN
read -p "Enter your Bearer Token: " TOKEN
echo ""
if [[ -z "$TOKEN" ]]; then
    log_error "TOKEN cannot be empty"
    exit 1
fi


echo ""
log_info "Configuration:"
echo "  SWIYU_PARTNER_ID: $SWIYU_PARTNER_ID"
echo "  IDENTIFIER_API_URL: $IDENTIFIER_API_URL"
echo "  IDENTIFIER_URL: $IDENTIFIER_URL"
echo "  TRUST_API_URL: $TRUST_API_URL"
echo ""

# Step 1: Get identifier information
log_info "Step 1: Fetching identifier information for business partner..."
IDENTIFIER_RESPONSE=$(curl -v -s -X GET \
  -H "Authorization: Bearer $TOKEN" \
  "$IDENTIFIER_API_URL/api/v1/identifier/business-entities/$SWIYU_PARTNER_ID/identifier/")

if [[ -z "$IDENTIFIER_RESPONSE" ]]; then
    log_error "Failed to get identifier information"
    exit 1
fi

echo "$IDENTIFIER_RESPONSE" | jq . 2>/dev/null || log_warning "Response is not valid JSON"

# Extract the first identifier ID and status
IDENTIFIER_REGISTRY_ID=$(echo "$IDENTIFIER_RESPONSE" | jq -r '.content[0].id // empty')
IDENTIFIER_STATUS=$(echo "$IDENTIFIER_RESPONSE" | jq -r '.content[0].status // empty')

if [[ -z "$IDENTIFIER_REGISTRY_ID" ]]; then
    log_error "No identifier found in response"
    exit 1
fi

log_success "Found identifier: $IDENTIFIER_REGISTRY_ID"
log_info "Identifier status: $IDENTIFIER_STATUS"
echo ""

# Check if identifier is already initialized
if [[ "$IDENTIFIER_STATUS" == "INITIALIZED" ]]; then
    log_success "Identifier is already INITIALIZED. Skipping DID log generation and upload steps."
    echo ""
else
    # Step 2: Generate DID log with didtoolbox
    log_info "Step 2: Generating DID log with didtoolbox..."
    DID_URL="$IDENTIFIER_URL/api/v1/did/$IDENTIFIER_REGISTRY_ID"

    mkdir -p did1
    if ! (cd did1 && java -jar ../didtoolbox-1.3.1-jar-with-dependencies.jar create --identifier-registry-url "$DID_URL") > did1/didlog.jsonl; then
        log_error "Failed to generate DID log"
        exit 1
    fi

    log_success "DID log generated: did1/didlog.jsonl"
    echo ""

    # Step 3: Upload DID log to endpoint
    log_info "Step 3: Uploading DID log..."
    UPLOAD_RESPONSE=$(curl -s -w "\n%{http_code}" --data-binary @did1/didlog.jsonl \
      -H "Authorization: Bearer $TOKEN" \
      -H "Content-Type: application/jsonl+json" \
      -X PUT "$IDENTIFIER_API_URL/api/v1/identifier/business-entities/$SWIYU_PARTNER_ID/identifier-entries/$IDENTIFIER_REGISTRY_ID")

    HTTP_CODE=$(echo "$UPLOAD_RESPONSE" | tail -n1)
    RESPONSE_BODY=$(echo "$UPLOAD_RESPONSE" | sed '$d')

    if [[ "$HTTP_CODE" =~ ^2[0-9]{2}$ ]]; then
        log_success "DID log uploaded successfully (HTTP $HTTP_CODE)"
    else
        log_error "Failed to upload DID log (HTTP $HTTP_CODE)"
        echo "$RESPONSE_BODY"
        exit 1
    fi
    echo ""

    # Step 4: Wait for user confirmation
    log_warning "IMPORTANT: Please ensure the trust onboarding submission has been created before continuing."
    read -p "Press Enter to continue once the trust onboarding submission is ready..."
    echo ""
fi

# Step 4 (or Step 5 if skipped): Get proof of possession challenge
log_info "Step 4: Fetching proof of possession challenge..."
POP_RESPONSE=$(curl -s -X GET \
  -H "Authorization: Bearer $TOKEN" \
  "$TRUST_API_URL/api/v1/trust/trust-onboarding-submission/proof-of-possessions")

if [[ -z "$POP_RESPONSE" ]]; then
    log_error "Failed to get proof of possession information"
    exit 1
fi

echo "$POP_RESPONSE" | jq . 2>/dev/null || log_warning "Response is not valid JSON"

# Extract DID and nonce
DID=$(echo "$POP_RESPONSE" | jq -r '.[0].did // empty')
NONCE=$(echo "$POP_RESPONSE" | jq -r '.[0].nonce // empty')

if [[ -z "$DID" ]] || [[ -z "$NONCE" ]]; then
    log_error "Could not extract DID or nonce from response"
    exit 1
fi

log_success "Received challenge:"
echo "  DID: $DID"
echo "  NONCE: $NONCE"
echo ""

# Step 6: Create proof of possession JWT
log_info "Step 5: Creating proof of possession JWT..."
if ! bash ../proof-of-possession/create-pop.sh "${DID}#assert-key-01" "$NONCE" "$DID" "did1/.didtoolbox/assert-key-01" > did1/pop.jwt; then
    log_error "Failed to create proof of possession"
    exit 1
fi

POP_JWT=$(cat did1/pop.jwt)
log_success "Proof of possession JWT created"
echo ""

# Step 7: Upload proof of possession
log_info "Step 6: Uploading proof of possession..."
POP_PAYLOAD=$(jq -n --arg jwt "$POP_JWT" '{proofOfPossessions: [$jwt]}')

POP_UPLOAD_RESPONSE=$(curl -s -w "\n%{http_code}" -X POST \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d "$POP_PAYLOAD" \
  "$TRUST_API_URL/api/v1/trust/trust-onboarding-submission/proof-of-possessions")

HTTP_CODE=$(echo "$POP_UPLOAD_RESPONSE" | tail -n1)
RESPONSE_BODY=$(echo "$POP_UPLOAD_RESPONSE" | sed '$d')

if [[ "$HTTP_CODE" =~ ^2[0-9]{2}$ ]]; then
    log_success "Proof of possession uploaded successfully (HTTP $HTTP_CODE)"
    echo "$RESPONSE_BODY" | jq . 2>/dev/null || echo "$RESPONSE_BODY"
else
    log_error "Failed to upload proof of possession (HTTP $HTTP_CODE)"
    echo "$RESPONSE_BODY"
    exit 1
fi
echo ""

log_success "First DID flow completed successfully!"
echo ""

# Step 7: Wait for user input before creating the second DID
log_warning "Second DID creation: ready to create a new identifier entry."
read -p "Press Enter to continue and create the second identifier entry..."
echo ""

# Step 8: Create a new identifier entry via POST
CORE_BUSINESS_SERVICE_URL="https://swiyu-core-business-service-int-a.apps.p-szb-ros-shrd-npr-01.cloud.admin.ch"
log_info "Step 7: Creating a new identifier entry for second DID..."
CREATE_RESPONSE=$(curl -s -w "\n%{http_code}" -X POST \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  "$CORE_BUSINESS_SERVICE_URL/api/v1/identifier/business-entities/$SWIYU_PARTNER_ID/identifier-entries/")

HTTP_CODE=$(echo "$CREATE_RESPONSE" | tail -n1)
RESPONSE_BODY=$(echo "$CREATE_RESPONSE" | sed '$d')

if [[ "$HTTP_CODE" =~ ^2[0-9]{2}$ ]]; then
    log_success "New identifier entry created successfully (HTTP $HTTP_CODE)"
    echo "$RESPONSE_BODY" | jq . 2>/dev/null || echo "$RESPONSE_BODY"
else
    log_error "Failed to create new identifier entry (HTTP $HTTP_CODE)"
    echo "$RESPONSE_BODY"
    exit 1
fi

IDENTIFIER_REGISTRY_ID_2=$(echo "$RESPONSE_BODY" | jq -r '.id // empty')
if [[ -z "$IDENTIFIER_REGISTRY_ID_2" ]]; then
    log_error "Could not extract new identifier ID from response"
    exit 1
fi
log_success "Second identifier ID: $IDENTIFIER_REGISTRY_ID_2"
echo ""

# Step 9: Prepare did2 directory for second identifier
log_info "Step 8: Preparing did2 directory for second identifier..."
rm -rf did2
mkdir -p did2
log_success "did2 directory ready"
echo ""

# Step 10: Generate DID log for the second identifier
log_info "Step 9: Generating DID log for second identifier..."
DID_URL_2="$IDENTIFIER_URL/api/v1/did/$IDENTIFIER_REGISTRY_ID_2"

if ! (cd did2 && java -jar ../didtoolbox-1.3.1-jar-with-dependencies.jar create --identifier-registry-url "$DID_URL_2") > did2/didlog.jsonl; then
    log_error "Failed to generate DID log for second identifier"
    exit 1
fi

log_success "DID log generated: did2/didlog.jsonl"
echo ""

# Step 11: Upload DID log for second identifier
log_info "Step 10: Uploading DID log for second identifier..."
UPLOAD_RESPONSE_2=$(curl -s -w "\n%{http_code}" --data-binary @did2/didlog.jsonl \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/jsonl+json" \
  -X PUT "$IDENTIFIER_API_URL/api/v1/identifier/business-entities/$SWIYU_PARTNER_ID/identifier-entries/$IDENTIFIER_REGISTRY_ID_2")

HTTP_CODE=$(echo "$UPLOAD_RESPONSE_2" | tail -n1)
RESPONSE_BODY=$(echo "$UPLOAD_RESPONSE_2" | sed '$d')

if [[ "$HTTP_CODE" =~ ^2[0-9]{2}$ ]]; then
    log_success "DID log for second identifier uploaded successfully (HTTP $HTTP_CODE)"
else
    log_error "Failed to upload DID log for second identifier (HTTP $HTTP_CODE)"
    echo "$RESPONSE_BODY"
    exit 1
fi
echo ""

# Step 12: Extract second DID string from did2/didlog.jsonl
DID_2_STRING=$(head -1 did2/didlog.jsonl | jq -r '[.. | strings | select(startswith("did:tdw:Q"))] | first // empty')
if [[ -z "$DID_2_STRING" ]]; then
    log_error "Could not extract second DID string from didlog.jsonl"
    exit 1
fi
log_success "Second DID string: $DID_2_STRING"
echo ""

# Step 13: Create trust-add-dids-submission
log_info "Step 11: Creating trust-add-dids-submission..."
ADD_DIDS_PAYLOAD=$(jq -n --arg permDid "$DID" --arg did2 "$DID_2_STRING" \
    '{"permissionDid": $permDid, "didsToAdd": [$did2]}')

ADD_DIDS_RESPONSE=$(curl -s -w "\n%{http_code}" -X POST \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d "$ADD_DIDS_PAYLOAD" \
  "$TRUST_API_URL/api/v1/trust/trust-add-dids-submissions")

HTTP_CODE=$(echo "$ADD_DIDS_RESPONSE" | tail -n1)
RESPONSE_BODY=$(echo "$ADD_DIDS_RESPONSE" | sed '$d')

if [[ "$HTTP_CODE" =~ ^2[0-9]{2}$ ]]; then
    log_success "Trust-add-dids-submission created successfully (HTTP $HTTP_CODE)"
    echo "$RESPONSE_BODY" | jq . 2>/dev/null || echo "$RESPONSE_BODY"
else
    log_error "Failed to create trust-add-dids-submission (HTTP $HTTP_CODE)"
    echo "$RESPONSE_BODY"
    exit 1
fi

TRUST_ADD_SUBMISSION_ID=$(echo "$RESPONSE_BODY" | jq -r '.id // empty')
NONCE_2=$(echo "$RESPONSE_BODY" | jq -r '.nonce // empty')

if [[ -z "$TRUST_ADD_SUBMISSION_ID" ]]; then
    log_error "Could not extract id from trust-add-dids-submission response"
    exit 1
fi
if [[ -z "$NONCE_2" ]]; then
    log_error "Could not extract nonce from trust-add-dids-submission response"
    exit 1
fi
log_success "Trust-add-dids-submission ID: $TRUST_ADD_SUBMISSION_ID"
log_success "Received challenge for second DID:"
echo "  DID: $DID_2_STRING"
echo "  NONCE: $NONCE_2"
echo ""

# Step 15: Create proof of possession JWTs for both DIDs
log_info "Step 13: Creating proof of possession JWT for first DID (authorising add-dids)..."
if ! bash ../proof-of-possession/create-pop.sh "${DID}#assert-key-01" "$NONCE_2" "$DID" "did1/.didtoolbox/assert-key-01" > did1/pop2.jwt; then
    log_error "Failed to create proof of possession for first DID"
    exit 1
fi
POP_JWT_1_REASSERT=$(cat did1/pop2.jwt)
log_success "Proof of possession JWT created for first DID"

log_info "Step 13b: Creating proof of possession JWT for second DID..."
if ! bash ../proof-of-possession/create-pop.sh "${DID_2_STRING}#assert-key-01" "$NONCE_2" "$DID_2_STRING" "did2/.didtoolbox/assert-key-01" > did2/pop.jwt; then
    log_error "Failed to create proof of possession for second DID"
    exit 1
fi

POP_JWT_2=$(cat did2/pop.jwt)
log_success "Proof of possession JWT created for second DID"
echo ""

# Step 16: Upload proof of possession for both DIDs
log_info "Step 14: Uploading proof of possession for both DIDs..."
POP_PAYLOAD_2=$(jq -n --arg jwt1 "$POP_JWT_1_REASSERT" --arg jwt2 "$POP_JWT_2" '{proofOfPossessions: [$jwt1, $jwt2]}')

POP_UPLOAD_RESPONSE_2=$(curl -s -w "\n%{http_code}" -X POST \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d "$POP_PAYLOAD_2" \
  "$TRUST_API_URL/api/v1/trust/trust-add-dids-submissions/$TRUST_ADD_SUBMISSION_ID")

HTTP_CODE=$(echo "$POP_UPLOAD_RESPONSE_2" | tail -n1)
RESPONSE_BODY=$(echo "$POP_UPLOAD_RESPONSE_2" | sed '$d')

if [[ "$HTTP_CODE" =~ ^2[0-9]{2}$ ]]; then
    log_success "Proof of possession for second DID uploaded successfully (HTTP $HTTP_CODE)"
    echo "$RESPONSE_BODY" | jq . 2>/dev/null || echo "$RESPONSE_BODY"
else
    log_error "Failed to upload proof of possession for second DID (HTTP $HTTP_CODE)"
    echo "$RESPONSE_BODY"
    exit 1
fi
echo ""

log_success "System demo completed successfully! Both DIDs have been set up."
echo ""
log_info "Generated files:"
echo "  - did1/didlog.jsonl  (first DID log)"
echo "  - did1/.didtoolbox/  (first DID keys)"
echo "  - did1/pop.jwt       (first DID initial PoP)"
echo "  - did1/pop2.jwt      (first DID re-assertion PoP)"
echo "  - did2/didlog.jsonl  (second DID log)"
echo "  - did2/.didtoolbox/  (second DID keys)"
echo "  - did2/pop.jwt       (second DID PoP)"

