$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 64 mm barrel, 18 mm wide, bore 7.94 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 7.94;            // bore
barrel_d = 64;            // barrel diameter
roller_w = 18;            // roller width
groove_w = 5;             // guide groove width
groove_d = 4;             // guide groove depth

roller_profile = [[3.97, 0], [32, 0], [32, 6.5], [28, 9], [32, 11.5], [32, 18], [3.97, 18]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
