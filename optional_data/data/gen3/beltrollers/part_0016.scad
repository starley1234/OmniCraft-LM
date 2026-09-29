$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 64 mm barrel, 34 mm wide, bore 9.52 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 9.52;            // bore
barrel_d = 64;            // barrel diameter
roller_w = 34;            // roller width
flange_d = 84;            // flange diameter
flange_t = 4;             // flange thickness
hub_d = 33.52;            // hub diameter

roller_profile = [[4.76, 0], [42, 0], [42, 4], [32, 4], [33.4, 17], [32, 30], [42, 30], [42, 34], [4.76, 34]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
