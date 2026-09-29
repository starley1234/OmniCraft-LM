$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 64 mm barrel, 30 mm wide, bore 9.52 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 9.52;            // bore
barrel_d = 64;            // barrel diameter
roller_w = 30;            // roller width
flange_d = 80;            // flange diameter
flange_t = 4;             // flange thickness
hub_d = 29.52;            // hub diameter

roller_profile = [[4.76, 0], [40, 0], [40, 4], [32, 4], [33, 15], [32, 26], [40, 26], [40, 30], [4.76, 30]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
