$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 40 mm barrel, 30 mm wide, bore 7.94 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 7.94;            // bore
barrel_d = 40;            // barrel diameter
roller_w = 30;            // roller width
groove_w = 5;             // guide groove width
groove_d = 4;             // guide groove depth

roller_profile = [[3.97, 0], [20, 0], [20, 12.5], [16, 15], [20, 17.5], [20, 30], [3.97, 30]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
