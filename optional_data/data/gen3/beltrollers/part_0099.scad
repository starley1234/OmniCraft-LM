$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 40 mm barrel, 28 mm wide, bore 15.88 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 15.88;           // bore
barrel_d = 40;            // barrel diameter
roller_w = 28;            // roller width
flange_d = 56;            // flange diameter
flange_t = 5;             // flange thickness
hub_d = 31.88;            // hub diameter

roller_profile = [[7.94, 0], [28, 0], [28, 5], [20, 5], [21, 14], [20, 23], [28, 23], [28, 28], [7.94, 28]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
