$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 40 mm barrel, 26 mm wide, bore 9.52 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 9.52;            // bore
barrel_d = 40;            // barrel diameter
roller_w = 26;            // roller width
groove_w = 7;             // guide groove width
groove_d = 4;             // guide groove depth

roller_profile = [[4.76, 0], [20, 0], [20, 9.5], [16, 13], [20, 16.5], [20, 26], [4.76, 26]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
