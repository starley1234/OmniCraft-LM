$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 56 mm barrel, 26 mm wide, bore 12.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 12.7;            // bore
barrel_d = 56;            // barrel diameter
roller_w = 26;            // roller width
crown = 0.6;              // crown height at mid width

roller_profile = [[6.35, 0], [28, 0], [28.6, 13], [28, 26], [6.35, 26]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
