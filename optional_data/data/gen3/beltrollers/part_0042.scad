$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 40 mm barrel, 18 mm wide, bore 15.88 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 15.88;           // bore
barrel_d = 40;            // barrel diameter
roller_w = 18;            // roller width
groove_w = 6;             // guide groove width
groove_d = 3;             // guide groove depth

roller_profile = [[7.94, 0], [20, 0], [20, 6], [17, 9], [20, 12], [20, 18], [7.94, 18]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
