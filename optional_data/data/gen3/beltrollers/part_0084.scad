$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 64 mm barrel, 30 mm wide, bore 7.94 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 7.94;            // bore
barrel_d = 64;            // barrel diameter
roller_w = 30;            // roller width
groove_w = 7;             // guide groove width
groove_d = 3;             // guide groove depth

roller_profile = [[3.97, 0], [32, 0], [32, 11.5], [29, 15], [32, 18.5], [32, 30], [3.97, 30]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
