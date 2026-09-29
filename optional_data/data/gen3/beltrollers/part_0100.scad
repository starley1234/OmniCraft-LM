$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 48 mm barrel, 26 mm wide, bore 7.94 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 7.94;            // bore
barrel_d = 48;            // barrel diameter
roller_w = 26;            // roller width
groove_w = 5;             // guide groove width
groove_d = 5;             // guide groove depth

roller_profile = [[3.97, 0], [24, 0], [24, 10.5], [19, 13], [24, 15.5], [24, 26], [3.97, 26]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
