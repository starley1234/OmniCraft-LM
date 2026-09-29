$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 40 mm barrel, 22 mm wide, bore 15.88 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 15.88;           // bore
barrel_d = 40;            // barrel diameter
roller_w = 22;            // roller width
groove_w = 5;             // guide groove width
groove_d = 5;             // guide groove depth

roller_profile = [[7.94, 0], [20, 0], [20, 8.5], [15, 11], [20, 13.5], [20, 22], [7.94, 22]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
