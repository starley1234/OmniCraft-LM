$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 40 mm barrel, 26 mm wide, bore 15.88 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 15.88;           // bore
barrel_d = 40;            // barrel diameter
roller_w = 26;            // roller width
groove_w = 6;             // guide groove width
groove_d = 4;             // guide groove depth

roller_profile = [[7.94, 0], [20, 0], [20, 10], [16, 13], [20, 16], [20, 26], [7.94, 26]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
