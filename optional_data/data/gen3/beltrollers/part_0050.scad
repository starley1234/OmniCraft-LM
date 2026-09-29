$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 64 mm barrel, 26 mm wide, bore 7.94 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 7.94;            // bore
barrel_d = 64;            // barrel diameter
roller_w = 26;            // roller width
crown = 0.6;              // crown height at mid width

roller_profile = [[3.97, 0], [32, 0], [32.6, 13], [32, 26], [3.97, 26]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
