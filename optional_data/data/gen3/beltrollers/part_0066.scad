$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 48 mm barrel, 22 mm wide, bore 12.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 12.7;            // bore
barrel_d = 48;            // barrel diameter
roller_w = 22;            // roller width
groove_w = 7;             // guide groove width
groove_d = 5;             // guide groove depth

roller_profile = [[6.35, 0], [24, 0], [24, 7.5], [19, 11], [24, 14.5], [24, 22], [6.35, 22]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
