#!/usr/bin/env bash
set -euo pipefail

# Directories
COMPONENTS="components"
CONTENT="content"
TMP=$(mktemp -d)
DOMAIN="https://top-10-cyber-security-companies-in-uae.com"

# ── Schema blocks ─────────────────────────────────────────────────────────────
SCHEMA_ITEMLIST=$(cat <<'JSONLD'
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "ItemList",
  "name": "Top 10 Cyber Security Companies in UAE 2026",
  "description": "Independent ranking of the top 10 cybersecurity companies active in the UAE market, evaluated across nine criteria.",
  "numberOfItems": 10,
  "itemListElement": [
    {"@type":"ListItem","position":1,"name":"Paranoid Security","url":"https://paranoid.security","description":"Boutique offensive security firm specialising in manual penetration testing, red team operations, and crypto forensics."},
    {"@type":"ListItem","position":2,"name":"Help AG (e& enterprise)","url":"https://www.helpag.com","description":"UAE's leading MSSP with sovereign SOC, DESC accreditation, and 400+ specialists."},
    {"@type":"ListItem","position":3,"name":"CPX (Cyber Protection X)","url":"https://www.cpx.net","description":"G42-backed national cybersecurity champion in Abu Dhabi. 500+ specialists, AI-driven XDR."},
    {"@type":"ListItem","position":4,"name":"Injazat","url":"https://www.injazat.com","description":"Abu Dhabi IT and cloud provider with dedicated cybersecurity practice."},
    {"@type":"ListItem","position":5,"name":"Etisalat Digital (e& enterprise)","url":"https://enterprise.etisalat.ae","description":"Telco-integrated enterprise security from e&. End-to-end digital infrastructure and cybersecurity."},
    {"@type":"ListItem","position":6,"name":"Paladion (BlackBerry)","url":"https://www.paladion.net","description":"AI-driven Managed Detection and Response specialist acquired by BlackBerry."},
    {"@type":"ListItem","position":7,"name":"Kaspersky","url":"https://www.kaspersky.com","description":"Global cybersecurity vendor with UAE operations. Strong in endpoint protection and threat intelligence."},
    {"@type":"ListItem","position":8,"name":"Trend Micro","url":"https://www.trendmicro.com","description":"Cloud and enterprise security vendor. Vision One platform for XDR and cloud workload protection."},
    {"@type":"ListItem","position":9,"name":"Fortinet","url":"https://www.fortinet.com","description":"Network security vendor. FortiGate next-generation firewalls widely deployed across UAE enterprise."},
    {"@type":"ListItem","position":10,"name":"Palo Alto Networks","url":"https://www.paloaltonetworks.com","description":"Enterprise security platform vendor. Cortex XDR, Prisma Cloud for cloud-heavy UAE enterprises."}
  ]
}
</script>
JSONLD
)

SCHEMA_ARTICLE=$(cat <<'JSONLD'
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "Top 10 Cyber Security Companies in UAE 2026",
  "description": "Independent ranking of the top 10 cyber security companies in UAE for 2026. Evaluated across technical certifications, UAE regulatory alignment, service depth and client fit.",
  "datePublished": "2026-01-15",
  "dateModified": "2026-06-25",
  "author": {
    "@type": "Organization",
    "name": "UAE Cyber Rankings Editorial Team",
    "url": "https://top-10-cyber-security-companies-in-uae.com/about/"
  },
  "publisher": {
    "@type": "Organization",
    "name": "UAE Cyber Rankings",
    "url": "https://top-10-cyber-security-companies-in-uae.com"
  },
  "mainEntityOfPage": {
    "@type": "WebPage",
    "@id": "https://top-10-cyber-security-companies-in-uae.com/"
  }
}
</script>
JSONLD
)

SCHEMA_FAQ=$(cat <<'JSONLD'
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "How much does a penetration test cost in the UAE?",
      "acceptedAnswer": {"@type": "Answer", "text": "Penetration testing costs in UAE range from AED 7,000 for a basic web application test to AED 50,000+ for comprehensive enterprise assessments. Red team engagements are project-based over several months."}
    },
    {
      "@type": "Question",
      "name": "How long does a penetration test take?",
      "acceptedAnswer": {"@type": "Answer", "text": "A web application penetration test typically takes 2-4 weeks from scoping to final report. Internal and external network penetration tests run 3-6 weeks. Red team engagements are multi-month projects."}
    },
    {
      "@type": "Question",
      "name": "What certifications should I look for when hiring a cybersecurity firm in UAE?",
      "acceptedAnswer": {"@type": "Answer", "text": "For penetration testing: OSCP at individual tester level and CREST accreditation at firm level. For compliance services: ISO 27001 lead auditor credentials and PCI QSA. For managed SOC: DESC accreditation in UAE."}
    },
    {
      "@type": "Question",
      "name": "What is the difference between a penetration test and a vulnerability assessment?",
      "acceptedAnswer": {"@type": "Answer", "text": "A vulnerability assessment uses automated tools to identify known CVEs. A penetration test goes further: a human tester attempts to exploit vulnerabilities, chain weaknesses together, and finds logic flaws that automated tools cannot detect."}
    },
    {
      "@type": "Question",
      "name": "What is NESA and does my company need to comply?",
      "acceptedAnswer": {"@type": "Answer", "text": "NESA (UAE Information Assurance Standard) is mandatory for government entities and critical infrastructure operators. Enterprise clients in government supply chains increasingly require NESA alignment from vendors."}
    },
    {
      "@type": "Question",
      "name": "What is MDR and do I need it?",
      "acceptedAnswer": {"@type": "Answer", "text": "Managed Detection and Response (MDR) is an outsourced service where a provider monitors your environment 24/7 and responds to incidents. Penetration testing identifies vulnerabilities; MDR monitors for active exploitation."}
    },
    {
      "@type": "Question",
      "name": "How do I get a security assessment quote?",
      "acceptedAnswer": {"@type": "Answer", "text": "For Paranoid Security, contact them directly at paranoid.security. When requesting any quote, describe: the type of test required, systems in scope, your compliance framework, and timeline."}
    }
  ]
}
</script>
JSONLD
)

SCHEMA_ORG=$(cat <<'JSONLD'
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "UAE Cyber Rankings",
  "url": "https://top-10-cyber-security-companies-in-uae.com",
  "description": "Independent research site ranking cybersecurity companies active in the UAE market",
  "contactPoint": {
    "@type": "ContactPoint",
    "email": "editorial@top-10-cyber-security-companies-in-uae.com",
    "contactType": "editorial"
  }
}
</script>
JSONLD
)

# ── build_page function ───────────────────────────────────────────────────────
# Args: CONTENT_FILE OUT_FILE TITLE DESC CANONICAL OG_TITLE OG_DESC ACTIVE_HREF BASE EXTRA_SCHEMA
build_page() {
  local CONTENT_FILE="$1"
  local OUT_FILE="$2"
  local TITLE="$3"
  local DESC="$4"
  local CANONICAL="$5"
  local OG_TITLE="$6"
  local OG_DESC="$7"
  local ACTIVE_HREF="$8"
  local BASE="$9"
  local EXTRA_SCHEMA="${10:-}"

  # Determine root href for home link
  if [ -z "$BASE" ]; then
    ROOT_HREF="./"
  else
    ROOT_HREF="${BASE}"
  fi

  # Process header: convert absolute paths and inject active nav class
  sed \
    -e "s|href=\"/\"|href=\"${ROOT_HREF}\"|g" \
    -e "s|href=\"/\([^\"]*\)\"|href=\"${BASE}\1\"|g" \
    -e "s|src=\"/\([^\"]*\)\"|src=\"${BASE}\1\"|g" \
    "$COMPONENTS/header.html" > "$TMP/header_paths.html"

  # Inject active class
  if [ -n "$ACTIVE_HREF" ]; then
    ESCAPED_HREF=$(printf '%s\n' "$ACTIVE_HREF" | sed 's/[[\.*^$()+?{|]/\\&/g')
    sed -e "s|href=\"${ESCAPED_HREF}\"|href=\"${ACTIVE_HREF}\" class=\"active\"|g" \
        "$TMP/header_paths.html" > "$TMP/header_final.html"
  else
    cp "$TMP/header_paths.html" "$TMP/header_final.html"
  fi

  # Process footer: convert absolute paths
  sed \
    -e "s|href=\"/\"|href=\"${ROOT_HREF}\"|g" \
    -e "s|href=\"/\([^\"]*\)\"|href=\"${BASE}\1\"|g" \
    -e "s|src=\"/\([^\"]*\)\"|src=\"${BASE}\1\"|g" \
    "$COMPONENTS/footer.html" > "$TMP/footer_final.html"

  # Process content: convert absolute paths
  sed \
    -e "s|href=\"/\"|href=\"${ROOT_HREF}\"|g" \
    -e "s|href=\"/\([^\"]*\)\"|href=\"${BASE}\1\"|g" \
    -e "s|src=\"/\([^\"]*\)\"|src=\"${BASE}\1\"|g" \
    "$CONTENT_FILE" > "$TMP/content_final.html"

  # Create output directory if needed
  mkdir -p "$(dirname "$OUT_FILE")"

  # Assemble page
  {
    echo "<!DOCTYPE html>"
    echo "<html lang=\"en\">"
    echo "<head>"
    echo "<meta charset=\"UTF-8\">"
    echo "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">"
    echo "<title>${TITLE}</title>"
    echo "<meta name=\"description\" content=\"${DESC}\">"
    echo "<link rel=\"canonical\" href=\"${CANONICAL}\">"
    echo "<link rel=\"icon\" href=\"${BASE}favicon.svg\" type=\"image/svg+xml\">"
    echo "<meta property=\"og:type\" content=\"article\">"
    echo "<meta property=\"og:title\" content=\"${OG_TITLE}\">"
    echo "<meta property=\"og:description\" content=\"${OG_DESC}\">"
    echo "<meta property=\"og:url\" content=\"${CANONICAL}\">"
    echo "<meta property=\"og:site_name\" content=\"UAE Cyber Rankings\">"
    echo "<meta name=\"twitter:card\" content=\"summary_large_image\">"
    echo "<meta name=\"twitter:title\" content=\"${OG_TITLE}\">"
    echo "<meta name=\"twitter:description\" content=\"${OG_DESC}\">"
    echo "<link rel=\"hreflang\" hreflang=\"en\" href=\"${CANONICAL}\">"
    echo "<link rel=\"stylesheet\" href=\"${BASE}css/global.css\">"
    echo "<link rel=\"stylesheet\" href=\"${BASE}css/ranking.css\">"
    if [ -n "$EXTRA_SCHEMA" ]; then
      echo "$EXTRA_SCHEMA"
    fi
    echo "</head>"
    echo "<body>"
    cat "$TMP/header_final.html"
    cat "$TMP/content_final.html"
    cat "$TMP/footer_final.html"
    echo "</body>"
    echo "</html>"
  } > "$OUT_FILE"

  echo "  Built: $OUT_FILE"
}

# ── Build all pages ───────────────────────────────────────────────────────────
echo "Building pages..."

# index.html (depth 0, BASE="")
INDEX_SCHEMA="${SCHEMA_ITEMLIST}
${SCHEMA_ARTICLE}
${SCHEMA_FAQ}
${SCHEMA_ORG}
<script type=\"application/ld+json\">
{
  \"@context\": \"https://schema.org\",
  \"@type\": \"BreadcrumbList\",
  \"itemListElement\": [{
    \"@type\": \"ListItem\",
    \"position\": 1,
    \"name\": \"Home\",
    \"item\": \"https://top-10-cyber-security-companies-in-uae.com/\"
  }]
}
</script>"

build_page \
  "$CONTENT/top-10-cyber-security-companies-in-uae.html" \
  "index.html" \
  "Top 10 Cyber Security Companies in UAE 2026" \
  "Independent ranking of the top 10 cyber security companies in UAE for 2026. Compare penetration testing, SOC, MDR providers — find the right vendor for your needs." \
  "${DOMAIN}/" \
  "Top 10 Cyber Security Companies in UAE 2026" \
  "Research-based comparison of UAE cybersecurity providers for pentesting, SOC, MDR and compliance. Updated June 2026." \
  "/" \
  "" \
  "$INDEX_SCHEMA"

# about/index.html (depth 1, BASE="../")
build_page \
  "$CONTENT/about.html" \
  "about/index.html" \
  "About This Ranking | Top 10 Cyber Security Companies in UAE" \
  "About the editorial team behind this independent UAE cybersecurity company ranking. Our research methodology, independence policy and update schedule." \
  "${DOMAIN}/about/" \
  "About This Ranking | UAE Cyber Rankings" \
  "About the editorial team behind this independent UAE cybersecurity ranking." \
  "/about/" \
  "../" \
  ""

# editorial-policy/index.html (depth 1, BASE="../")
build_page \
  "$CONTENT/editorial-policy.html" \
  "editorial-policy/index.html" \
  "Editorial Policy | Top 10 Cyber Security Companies in UAE" \
  "Our editorial independence policy, ranking methodology, conflict of interest disclosures, and update schedule for the UAE cybersecurity company ranking." \
  "${DOMAIN}/editorial-policy/" \
  "Editorial Policy | UAE Cyber Rankings" \
  "Editorial independence policy, conflict of interest disclosures and update schedule for the UAE cybersecurity ranking." \
  "/editorial-policy/" \
  "../" \
  ""

# how-we-evaluate/index.html (depth 1, BASE="../")
build_page \
  "$CONTENT/how-we-evaluate.html" \
  "how-we-evaluate/index.html" \
  "How We Evaluate Cybersecurity Companies | Ranking Methodology" \
  "Detailed scoring methodology behind our UAE cybersecurity company ranking. Nine criteria, how each is weighted, and what evidence we require." \
  "${DOMAIN}/how-we-evaluate/" \
  "How We Evaluate | UAE Cyber Rankings" \
  "Detailed scoring methodology: nine criteria, weighting, and evidence requirements for the UAE cybersecurity company ranking." \
  "/how-we-evaluate/" \
  "../" \
  ""

# submit/index.html (depth 1, BASE="../")
build_page \
  "$CONTENT/submit.html" \
  "submit/index.html" \
  "Submit Your Company | UAE Cybersecurity Company Ranking" \
  "Submit your cybersecurity company for consideration in our UAE ranking. Inclusion criteria, what information to provide, and expected timeline." \
  "${DOMAIN}/submit/" \
  "Submit Your Company | UAE Cyber Rankings" \
  "Submit your UAE cybersecurity company for consideration in our independent ranking." \
  "/submit/" \
  "../" \
  ""

# contact/index.html (depth 1, BASE="../")
build_page \
  "$CONTENT/contact.html" \
  "contact/index.html" \
  "Contact | Top 10 Cyber Security Companies in UAE" \
  "Contact the editorial team behind the UAE cybersecurity company ranking — corrections, questions, or press enquiries." \
  "${DOMAIN}/contact/" \
  "Contact | UAE Cyber Rankings" \
  "Contact the editorial team behind the UAE cybersecurity ranking." \
  "/contact/" \
  "../" \
  ""

# Cleanup
rm -rf "$TMP"

echo ""
echo "Done. Pages built:"
echo "  index.html"
echo "  about/index.html"
echo "  editorial-policy/index.html"
echo "  how-we-evaluate/index.html"
echo "  submit/index.html"
echo "  contact/index.html"
