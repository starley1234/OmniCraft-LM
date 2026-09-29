$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 64 mm barrel, 22 mm wide, bore 15.88 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 15.88;           // bore
barrel_d = 64;            // barrel diameter
roller_w = 22;            // roller width
groove_w = 6;             // guide groove width
groove_d = 4;             // guide groove depth

roller_profile = [[7.94, 0], [32, 0], [32, 8], [28, 11], [32, 14], [32, 22], [7.94, 22]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
