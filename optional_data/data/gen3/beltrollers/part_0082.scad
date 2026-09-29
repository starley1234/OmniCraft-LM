$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 48 mm barrel, 34 mm wide, bore 12.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 12.7;            // bore
barrel_d = 48;            // barrel diameter
roller_w = 34;            // roller width
flange_d = 68;            // flange diameter
flange_t = 4;             // flange thickness
hub_d = 36.7;             // hub diameter

roller_profile = [[6.35, 0], [34, 0], [34, 4], [24, 4], [25.4, 17], [24, 30], [34, 30], [34, 34], [6.35, 34]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
