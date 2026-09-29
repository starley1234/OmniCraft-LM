$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 40 mm barrel, 22 mm wide, bore 15.88 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 15.88;           // bore
barrel_d = 40;            // barrel diameter
roller_w = 22;            // roller width
crown = 1;                // crown height at mid width

roller_profile = [[7.94, 0], [20, 0], [21, 11], [20, 22], [7.94, 22]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
