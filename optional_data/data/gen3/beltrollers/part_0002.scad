$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 56 mm barrel, 30 mm wide, bore 9.52 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 9.52;            // bore
barrel_d = 56;            // barrel diameter
roller_w = 30;            // roller width
crown = 0.6;              // crown height at mid width

roller_profile = [[4.76, 0], [28, 0], [28.6, 15], [28, 30], [4.76, 30]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
