$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 40 mm barrel, 26 mm wide, bore 7.94 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 7.94;            // bore
barrel_d = 40;            // barrel diameter
roller_w = 26;            // roller width
crown = 1.4;              // crown height at mid width

roller_profile = [[3.97, 0], [20, 0], [21.4, 13], [20, 26], [3.97, 26]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
