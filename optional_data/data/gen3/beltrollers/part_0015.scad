$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 56 mm barrel, 26 mm wide, bore 7.94 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 7.94;            // bore
barrel_d = 56;            // barrel diameter
roller_w = 26;            // roller width
groove_w = 7;             // guide groove width
groove_d = 5;             // guide groove depth

roller_profile = [[3.97, 0], [28, 0], [28, 9.5], [23, 13], [28, 16.5], [28, 26], [3.97, 26]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
