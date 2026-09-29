$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 56 mm barrel, 30 mm wide, bore 9.52 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 9.52;            // bore
barrel_d = 56;            // barrel diameter
roller_w = 30;            // roller width
groove_w = 6;             // guide groove width
groove_d = 4;             // guide groove depth

roller_profile = [[4.76, 0], [28, 0], [28, 12], [24, 15], [28, 18], [28, 30], [4.76, 30]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
