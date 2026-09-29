$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 40 mm barrel, 22 mm wide, bore 12.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 12.7;            // bore
barrel_d = 40;            // barrel diameter
roller_w = 22;            // roller width
crown = 1;                // crown height at mid width

roller_profile = [[6.35, 0], [20, 0], [21, 11], [20, 22], [6.35, 22]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
