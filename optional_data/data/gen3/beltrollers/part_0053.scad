$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 56 mm barrel, 32 mm wide, bore 15.88 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 15.88;           // bore
barrel_d = 56;            // barrel diameter
roller_w = 32;            // roller width
flange_d = 72;            // flange diameter
flange_t = 5;             // flange thickness
hub_d = 39.88;            // hub diameter

roller_profile = [[7.94, 0], [36, 0], [36, 5], [28, 5], [29.4, 16], [28, 27], [36, 27], [36, 32], [7.94, 32]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
