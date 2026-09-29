$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 40 mm barrel, 26 mm wide, bore 9.52 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 9.52;            // bore
barrel_d = 40;            // barrel diameter
roller_w = 26;            // roller width
crown = 0.6;              // crown height at mid width

roller_profile = [[4.76, 0], [20, 0], [20.6, 13], [20, 26], [4.76, 26]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
