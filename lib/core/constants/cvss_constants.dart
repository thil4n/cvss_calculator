// CVSS v3.1 Official Metric Values
// Reference: https://www.first.org/cvss/v3.1/specification-document

// ---------------------------------------------------------------------------
// Attack Vector (AV)
// ---------------------------------------------------------------------------
const Map<String, double> attackVectorWeights = {
  'N': 0.85, // Network
  'A': 0.62, // Adjacent
  'L': 0.55, // Local
  'P': 0.20, // Physical
};

const Map<String, String> attackVectorLabels = {
  'N': 'Network',
  'A': 'Adjacent',
  'L': 'Local',
  'P': 'Physical',
};

// ---------------------------------------------------------------------------
// Attack Complexity (AC)
// ---------------------------------------------------------------------------
const Map<String, double> attackComplexityWeights = {
  'L': 0.77, // Low
  'H': 0.44, // High
};

const Map<String, String> attackComplexityLabels = {
  'L': 'Low',
  'H': 'High',
};

// ---------------------------------------------------------------------------
// Privileges Required (PR)
// Scope Unchanged / Scope Changed have different values
// ---------------------------------------------------------------------------
const Map<String, double> privilegesRequiredWeightsUnchanged = {
  'N': 0.85, // None
  'L': 0.62, // Low
  'H': 0.27, // High
};

const Map<String, double> privilegesRequiredWeightsChanged = {
  'N': 0.85, // None
  'L': 0.68, // Low
  'H': 0.50, // High
};

const Map<String, String> privilegesRequiredLabels = {
  'N': 'None',
  'L': 'Low',
  'H': 'High',
};

// ---------------------------------------------------------------------------
// User Interaction (UI)
// ---------------------------------------------------------------------------
const Map<String, double> userInteractionWeights = {
  'N': 0.85, // None
  'R': 0.62, // Required
};

const Map<String, String> userInteractionLabels = {
  'N': 'None',
  'R': 'Required',
};

// ---------------------------------------------------------------------------
// Scope (S)
// ---------------------------------------------------------------------------
const Map<String, String> scopeLabels = {
  'U': 'Unchanged',
  'C': 'Changed',
};

// ---------------------------------------------------------------------------
// Confidentiality Impact (C)
// ---------------------------------------------------------------------------
const Map<String, double> confidentialityWeights = {
  'N': 0.00, // None
  'L': 0.22, // Low
  'H': 0.56, // High
};

const Map<String, String> confidentialityLabels = {
  'N': 'None',
  'L': 'Low',
  'H': 'High',
};

// ---------------------------------------------------------------------------
// Integrity Impact (I)
// ---------------------------------------------------------------------------
const Map<String, double> integrityWeights = {
  'N': 0.00, // None
  'L': 0.22, // Low
  'H': 0.56, // High
};

const Map<String, String> integrityLabels = {
  'N': 'None',
  'L': 'Low',
  'H': 'High',
};

// ---------------------------------------------------------------------------
// Availability Impact (A)
// ---------------------------------------------------------------------------
const Map<String, double> availabilityWeights = {
  'N': 0.00, // None
  'L': 0.22, // Low
  'H': 0.56, // High
};

const Map<String, String> availabilityLabels = {
  'N': 'None',
  'L': 'Low',
  'H': 'High',
};

// ---------------------------------------------------------------------------
// Exploitability coefficient
// ---------------------------------------------------------------------------
const double exploitabilityCoefficient = 8.22;

// ---------------------------------------------------------------------------
// Scope multiplier when Scope is Changed
// ---------------------------------------------------------------------------
const double scopeChangedMultiplier = 1.08;