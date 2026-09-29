$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 40 mm barrel, 30 mm wide, bore 9.52 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 9.52;            // bore
barrel_d = 40;            // barrel diameter
roller_w = 30;            // roller width
groove_w = 7;             // guide groove width
groove_d = 3;             // guide groove depth

roller_profile = [[4.76, 0], [20, 0], [20, 11.5], [17, 15], [20, 18.5], [20, 30], [4.76, 30]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
