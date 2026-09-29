$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 56 mm barrel, 26 mm wide, bore 9.52 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 9.52;            // bore
barrel_d = 56;            // barrel diameter
roller_w = 26;            // roller width
crown = 1;                // crown height at mid width

roller_profile = [[4.76, 0], [28, 0], [29, 13], [28, 26], [4.76, 26]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
