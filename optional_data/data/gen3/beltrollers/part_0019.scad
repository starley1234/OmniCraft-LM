$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 48 mm barrel, 40 mm wide, bore 7.94 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 7.94;            // bore
barrel_d = 48;            // barrel diameter
roller_w = 40;            // roller width
flange_d = 68;            // flange diameter
flange_t = 5;             // flange thickness
hub_d = 27.94;            // hub diameter

roller_profile = [[3.97, 0], [34, 0], [34, 5], [24, 5], [25.4, 20], [24, 35], [34, 35], [34, 40], [3.97, 40]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
