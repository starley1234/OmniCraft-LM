$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 64 mm barrel, 22 mm wide, bore 12.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 12.7;            // bore
barrel_d = 64;            // barrel diameter
roller_w = 22;            // roller width
crown = 0.6;              // crown height at mid width

roller_profile = [[6.35, 0], [32, 0], [32.6, 11], [32, 22], [6.35, 22]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
