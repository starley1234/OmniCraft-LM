$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 64 mm barrel, 22 mm wide, bore 9.52 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 9.52;            // bore
barrel_d = 64;            // barrel diameter
roller_w = 22;            // roller width
groove_w = 5;             // guide groove width
groove_d = 5;             // guide groove depth

roller_profile = [[4.76, 0], [32, 0], [32, 8.5], [27, 11], [32, 13.5], [32, 22], [4.76, 22]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
