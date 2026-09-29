$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 48 mm barrel, 18 mm wide, bore 12.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 12.7;            // bore
barrel_d = 48;            // barrel diameter
roller_w = 18;            // roller width
crown = 1.4;              // crown height at mid width

roller_profile = [[6.35, 0], [24, 0], [25.4, 9], [24, 18], [6.35, 18]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
