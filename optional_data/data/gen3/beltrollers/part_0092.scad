$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 48 mm barrel, 26 mm wide, bore 9.52 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 9.52;            // bore
barrel_d = 48;            // barrel diameter
roller_w = 26;            // roller width
groove_w = 5;             // guide groove width
groove_d = 3;             // guide groove depth

roller_profile = [[4.76, 0], [24, 0], [24, 10.5], [21, 13], [24, 15.5], [24, 26], [4.76, 26]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
