$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 40 mm barrel, 38 mm wide, bore 7.94 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 7.94;            // bore
barrel_d = 40;            // barrel diameter
roller_w = 38;            // roller width
flange_d = 52;            // flange diameter
flange_t = 4;             // flange thickness
hub_d = 31.94;            // hub diameter

roller_profile = [[3.97, 0], [26, 0], [26, 4], [20, 4], [21, 19], [20, 34], [26, 34], [26, 38], [3.97, 38]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
