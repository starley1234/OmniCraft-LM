$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 48 mm barrel, 30 mm wide, bore 12.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 12.7;            // bore
barrel_d = 48;            // barrel diameter
roller_w = 30;            // roller width
groove_w = 6;             // guide groove width
groove_d = 4;             // guide groove depth

roller_profile = [[6.35, 0], [24, 0], [24, 12], [20, 15], [24, 18], [24, 30], [6.35, 30]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
