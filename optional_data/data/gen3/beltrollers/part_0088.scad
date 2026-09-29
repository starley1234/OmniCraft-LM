$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 56 mm barrel, 18 mm wide, bore 15.88 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 15.88;           // bore
barrel_d = 56;            // barrel diameter
roller_w = 18;            // roller width
groove_w = 7;             // guide groove width
groove_d = 3;             // guide groove depth

roller_profile = [[7.94, 0], [28, 0], [28, 5.5], [25, 9], [28, 12.5], [28, 18], [7.94, 18]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
