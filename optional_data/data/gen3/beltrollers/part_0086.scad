$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 64 mm barrel, 42 mm wide, bore 15.88 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 15.88;           // bore
barrel_d = 64;            // barrel diameter
roller_w = 42;            // roller width
flange_d = 76;            // flange diameter
flange_t = 6;             // flange thickness
hub_d = 39.88;            // hub diameter

roller_profile = [[7.94, 0], [38, 0], [38, 6], [32, 6], [32.6, 21], [32, 36], [38, 36], [38, 42], [7.94, 42]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
