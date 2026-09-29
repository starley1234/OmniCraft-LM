$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 56 mm barrel, 18 mm wide, bore 7.94 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 7.94;            // bore
barrel_d = 56;            // barrel diameter
roller_w = 18;            // roller width
groove_w = 6;             // guide groove width
groove_d = 3;             // guide groove depth

roller_profile = [[3.97, 0], [28, 0], [28, 6], [25, 9], [28, 12], [28, 18], [3.97, 18]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
