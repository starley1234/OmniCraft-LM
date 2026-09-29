$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 48 mm barrel, 30 mm wide, bore 7.94 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 7.94;            // bore
barrel_d = 48;            // barrel diameter
roller_w = 30;            // roller width
crown = 1;                // crown height at mid width

roller_profile = [[3.97, 0], [24, 0], [25, 15], [24, 30], [3.97, 30]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
