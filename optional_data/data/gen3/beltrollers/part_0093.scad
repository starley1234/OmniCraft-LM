$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 40 mm barrel, 22 mm wide, bore 7.94 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 7.94;            // bore
barrel_d = 40;            // barrel diameter
roller_w = 22;            // roller width
crown = 0.6;              // crown height at mid width

roller_profile = [[3.97, 0], [20, 0], [20.6, 11], [20, 22], [3.97, 22]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
