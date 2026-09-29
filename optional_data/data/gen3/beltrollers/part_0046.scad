$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 40 mm barrel, 22 mm wide, bore 7.94 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 7.94;            // bore
barrel_d = 40;            // barrel diameter
roller_w = 22;            // roller width
groove_w = 6;             // guide groove width
groove_d = 3;             // guide groove depth

roller_profile = [[3.97, 0], [20, 0], [20, 8], [17, 11], [20, 14], [20, 22], [3.97, 22]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
