$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 48 mm barrel, 26 mm wide, bore 7.94 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 7.94;            // bore
barrel_d = 48;            // barrel diameter
roller_w = 26;            // roller width
crown = 1;                // crown height at mid width

roller_profile = [[3.97, 0], [24, 0], [25, 13], [24, 26], [3.97, 26]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
