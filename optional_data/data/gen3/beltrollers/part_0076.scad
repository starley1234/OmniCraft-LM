$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 64 mm barrel, 30 mm wide, bore 12.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 12.7;            // bore
barrel_d = 64;            // barrel diameter
roller_w = 30;            // roller width
groove_w = 6;             // guide groove width
groove_d = 5;             // guide groove depth

roller_profile = [[6.35, 0], [32, 0], [32, 12], [27, 15], [32, 18], [32, 30], [6.35, 30]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
