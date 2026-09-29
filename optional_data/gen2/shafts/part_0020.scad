$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 30, 25, 16 mm, 115 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 30;                  // step 2 diameter
len2 = 40;                // step 2 length
d3 = 25;                  // step 3 diameter
len3 = 25;                // step 3 length
d4 = 16;                  // step 4 diameter
len4 = 20;                // step 4 length
total = 115;              // overall length
chamfer = 2;              // end chamfer
groove_r = 8;             // groove radius
groove_z = 97;            // groove position from the end
groove_w = 2;             // groove width
groove_d = 1.3;           // groove depth

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [25 - chamfer, 0], [25, chamfer], [25, 30], [15, 30], [15, 70], [12.5, 70], [12.5, 95], [8, 95], [8, 113], [6, 115], [0, 115]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
}
