$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 64 mm barrel, 26 mm wide, bore 9.52 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 9.52;            // bore
barrel_d = 64;            // barrel diameter
roller_w = 26;            // roller width
groove_w = 6;             // guide groove width
groove_d = 3;             // guide groove depth

roller_profile = [[4.76, 0], [32, 0], [32, 10], [29, 13], [32, 16], [32, 26], [4.76, 26]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
