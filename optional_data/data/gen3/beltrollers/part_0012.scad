$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 64 mm barrel, 34 mm wide, bore 7.94 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 7.94;            // bore
barrel_d = 64;            // barrel diameter
roller_w = 34;            // roller width
flange_d = 80;            // flange diameter
flange_t = 4;             // flange thickness
hub_d = 27.94;            // hub diameter

roller_profile = [[3.97, 0], [40, 0], [40, 4], [32, 4], [32.6, 17], [32, 30], [40, 30], [40, 34], [3.97, 34]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
