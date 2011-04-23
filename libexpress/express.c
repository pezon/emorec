/**
 *  @file
 *  @author Adam Vaughn
 */

#include <stdlib.h>
#include <string.h>

#include "express.h"

/**
 *  Find the maximum in an array of unsigned 32-bit integers.
 *
 *  @internal
 *
 *  @param a The array under inspection.
 *  @param l The length of the array.
 *  @param max A location at which to store the maximum.
 */
static int find_max (const uint32_t * const a, const uint32_t l,
		     uint32_t * const max);

/**
 *  Normalize an array of unsigned 32-bit integers up to an array of unsigned
 *  8-bit integers.
 *
 *  @internal
 *
 *  @param in The input array.
 *  @param n The length of the input array.
 *  @param max The maximum value of the input array.
 *  @param out The output array.
 */
static int norm_up (uint32_t const *const in, const uint32_t n,
		    const uint32_t max, uint8_t ** const out);

/**
 *  Normalize an array of unsigned 32-bit integers down to an array of unsigned
 *  8-bit integers.
 *
 *  @internal
 *
 *  @param in The input array.
 *  @param n The length of the input array.
 *  @param max The maximum value of the input array.
 *  @param out The output array.
 */
static int norm_down (uint32_t const *const in, const uint32_t n,
		      const uint32_t max, uint8_t ** const out);

struct
{
  uint32_t p;
  uint32_t t;
} t_table[] =
{
  {
  1, (uint32_t) (205.421 * MAGIC_CONSTANT)},
  {
  5, (uint32_t) (219.025 * MAGIC_CONSTANT)},
  {
  10, (uint32_t) (226.520 * MAGIC_CONSTANT)},
  {
  25, (uint32_t) (239.426 * MAGIC_CONSTANT)},
  {
  50, (uint32_t) (254.334 * MAGIC_CONSTANT)},
  {
  75, (uint32_t) (269.847 * MAGIC_CONSTANT)},
  {
  90, (uint32_t) (284.336 * MAGIC_CONSTANT)},
  {
  95, (uint32_t) (293.248 * MAGIC_CONSTANT)},
  {
99, (uint32_t) (310.457 * MAGIC_CONSTANT)}};

int
gen_histogram (uint8_t const *const image, const uint32_t h, const uint32_t w,
	       uint8_t ** const histogram)
{
  uint32_t *u;
  uint32_t x, y;
  uint8_t lbp;

  u = calloc (HIST_LEN, sizeof (*u));
  memset (u, 0, HIST_LEN * sizeof (*u));

  for (y = 0; y < h; y++)
    for (x = 0; x < w; x++)
      {
	calc_lbp (x, y, image, h, w, &lbp);
	u[lbp]++;
      }

  norm (u, UINT8_MAX, histogram);

  free(u);

  return SUCCESS;
}

int
calc_lbp (const uint32_t x, const uint32_t y, uint8_t const *const image,
	  const uint32_t h, const uint32_t w, uint8_t * const lbp)
{
  *lbp = 0;

  *lbp |= (x > 0
	   && y > 0 ? image[x + y * w] >
	   image[x - 1 + (y - 1) * w] : image[x + y * w] > 0) << 7;
  *lbp |=
    (y > 0 ? image[x + y * w] >
     image[x + (y - 1) * w] : image[x + y * w] > 0) << 6;
  *lbp |= (x < w - 1
	   && y > 0 ? image[x + y * w] >
	   image[x + 1 + (y - 1) * w] : image[x + y * w] > 0) << 5;
  *lbp |=
    (x < w - 1 ? image[x + y * w] >
     image[x + 1 + y * w] : image[x + y * w] > 0) << 4;
  *lbp |= (x < w - 1
	   && y < h - 1 ? image[x + y * w] >
	   image[x + 1 + (y + 1) * w] : image[x + y * w] > 0) << 3;
  *lbp |=
    (y < h - 1 ? image[x + y * w] >
     image[x + (y + 1) * w] : image[x + y * w] > 0) << 2;
  *lbp |= (x > 0
	   && y < h - 1 ? image[x + y * w] >
	   image[x - 1 + (y + 1) * w] : image[x + y * w] > 0) << 1;
  *lbp |=
    (x > 0 ? image[x + y * w] >
     image[x - 1 + y * w] : image[x + y * w] > 0) << 0;

  return SUCCESS;
}

int
norm (uint32_t const *const in, const uint32_t n, uint8_t ** const out)
{
  uint32_t max;

  find_max (in, n, &max);

  if (max > UINT8_MAX)
    {
      norm_down (in, n, max, out);
    }
  else
    {
      norm_up (in, n, max, out);
    }

  return SUCCESS;
}

int
calc_stat (const uint8_t * o, const uint8_t * e, const uint32_t l,
	   uint32_t * const s)
{
  uint32_t i;
  uint32_t t;

  *s = 0;

  for (i = 0; i < l; i++)
    {
      t = o[i] > e[i] ? o[i] - e[i] : e[i] - o[i];
      t *= t * MAGIC_CONSTANT;
      t /= e[i];

      *s += t;
    }

  return SUCCESS;
}

int
calc_p (const uint32_t t, uint32_t * const p)
{
  int i;

  *p = 0;

  for (i = 0; i < sizeof (t_table) / sizeof (*t_table); i++)
    if (t < t_table[i].t)
      {
	*p = t_table[i].p;
	break;
      }

  return SUCCESS;
}


int test_match(uint8_t const *const image, const uint32_t h, const uint32_t w, uint8_t const *const eigenface, uint32_t * const p)
{
  uint8_t *histogram;
  uint32_t t;

  gen_histogram(image, h, w, &histogram);
  calc_stat(histogram, eigenface, HIST_LEN, &t);
  calc_p(t, p);
  free(histogram);
}

int free_histogram(uint8_t *const histogram)
{
  free(histogram);

  return SUCCESS;
}

static int
find_max (const uint32_t * const a, const uint32_t l, uint32_t * const max)
{
  uint32_t i;

  *max = 0;

  for (i = 0; i < l; i++)
    if (a[i] > *max)
      *max = a[i];

  return SUCCESS;
}

static int
norm_up (uint32_t const *const in, const uint32_t n, const uint32_t max,
	 uint8_t ** const out)
{
  uint32_t i;

  *out = calloc (n, sizeof (**out));

  for (i = 0; i < n; i++)
    (*out)[i] =
      (uint8_t) (in[i] * ((UINT8_MAX * MAGIC_CONSTANT) / max) / MAGIC_CONSTANT);

  return SUCCESS;
}

static int
norm_down (uint32_t const *const in, const uint32_t n, const uint32_t max,
	   uint8_t ** const out)
{
  uint32_t i;
  uint32_t t;

  *out = calloc (n, sizeof (**out));

  for (i = 0; i < n; i++)
    {
      t = in[i] / (max / UINT8_MAX);

      if (t < UINT8_MAX)
	(*out)[i] = (uint8_t) t;
      else
	(*out)[i] = UINT8_MAX;
    }

  return SUCCESS;
}

