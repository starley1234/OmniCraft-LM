$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 56 mm barrel, 22 mm wide, bore 9.52 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 9.52;            // bore
barrel_d = 56;            // barrel diameter
roller_w = 22;            // roller width
crown = 1.4;              // crown height at mid width

roller_profile = [[4.76, 0], [28, 0], [29.4, 11], [28, 22], [4.76, 22]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
