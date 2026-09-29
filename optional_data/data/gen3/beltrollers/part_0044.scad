$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 40 mm barrel, 22 mm wide, bore 12.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 12.7;            // bore
barrel_d = 40;            // barrel diameter
roller_w = 22;            // roller width
groove_w = 7;             // guide groove width
groove_d = 5;             // guide groove depth

roller_profile = [[6.35, 0], [20, 0], [20, 7.5], [15, 11], [20, 14.5], [20, 22], [6.35, 22]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
