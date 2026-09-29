$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 40 mm barrel, 26 mm wide, bore 12.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 12.7;            // bore
barrel_d = 40;            // barrel diameter
roller_w = 26;            // roller width
flange_d = 52;            // flange diameter
flange_t = 4;             // flange thickness
hub_d = 28.7;             // hub diameter

roller_profile = [[6.35, 0], [26, 0], [26, 4], [20, 4], [21.4, 13], [20, 22], [26, 22], [26, 26], [6.35, 26]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
