import { test, expect } from '@playwright/test';

test.describe('Landing page', () => {
  test('shows template headline', async ({ page }) => {
    await page.goto('/');
    await expect(page.locator('h1')).toHaveText('GitHub Project Template');
  });
});
