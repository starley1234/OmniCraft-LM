$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 25, 16, 12 mm, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 25;                  // step 1 diameter
len1 = 25;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 10;                // step 2 length
d3 = 12;                  // step 3 diameter
len3 = 25;                // step 3 length
total = 60;               // overall length
chamfer = 1;              // end chamfer
groove_r = 8;             // groove radius
groove_z = 27;            // groove position from the end
groove_w = 3;             // groove width
groove_d = 1.6;           // groove depth

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [12.5 - chamfer, 0], [12.5, chamfer], [12.5, 25], [8, 25], [8, 35], [6, 35], [6, 59], [5, 60], [0, 60]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
}
