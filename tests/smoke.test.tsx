import { describe, it, expect } from "vitest";
import { renderToString } from "react-dom/server";
import App from "../src/App";

describe("App", () => {
  it("renders headline", () => {
    const html = renderToString(<App />);
    expect(html).toContain("GitHub Project Template");
  });
});
