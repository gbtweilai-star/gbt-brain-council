# brain_council

**One capability bit from GBT V8, packaged standalone.** No. 157 of 341,
`mind` domain (Mind).

<p>
<img alt="python" src="https://img.shields.io/badge/python-3.9%2B-blue">
<img alt="license" src="https://img.shields.io/badge/license-MIT-green">
<img alt="deps" src="https://img.shields.io/badge/runtime%20dependencies-0-brightgreen">
</p>

> 脑会·编队群决策引擎：各脑出本域提案，委员长聚合裁决（纯推演·不出网·不落盘）；执行仍走主脑既有授权门

That description is copied verbatim from the registry. `tests/test_spec.py` pins it,
so documentation drift fails the build instead of shipping quietly.

## What this package actually is

It is the **contract** for one capability: its name, its parameters, the values it
accepts, and whether it can change state that cannot be restored. It is not the
implementation — that lives in the runtime this bit was extracted from.

So `run()` goes through a narrow `Backend` protocol, and the default backend is a
stub that **says so**:

```
status="validated"   backend="stub"   data={"executed": false}
```

Never `status="ok"`. A stub that reports success is worse than no stub, because the
caller stops looking for the real thing.

## Install

```bash
git clone https://github.com/gbtweilai-star/gbt-brain-council.git
cd gbt-brain-council
python -m pip install -e ".[dev]"
```

## Use

```bash
python -m gbt_brain_council info                  # capability card
python -m gbt_brain_council spec --json           # machine-readable contract
python -m gbt_brain_council check --payload '{"op": "<在此填写>", "question": "<在此填写>"}'
python -m gbt_brain_council run   --payload '{"op": "<在此填写>", "question": "<在此填写>"}'
```

Real `info` output from this machine:

```text
brain_council  (mind)  v1.0.0
----------------------------------------
脑会·编队群决策引擎：各脑出本域提案，委员长聚合裁决（纯推演·不出网·不落盘）；执行仍走主脑既有授权门

gated      : False
external   : False
multi-op   : True
params     : op, question
             op=status（默认，读群与脑清单）| op=convene & question=…（召开脑会，返回裁决与提案）
values     : (multi-op, but the registry does not enumerate them)
```

Wire a real implementation:

```python
from gbt_brain_council import run

class MyBackend:
    name = "my-backend"
    def invoke(self, cap, payload):
        return {"cap": cap, "handled": sorted(payload)}

result = run({"op": "<在此填写>", "question": "<在此填写>"}, backend=MyBackend())
assert result.status == "ok"
```

## Parameters

| name | required | notes |
|---|---|---|
| `op` | yes | declared required by the registry |
| `question` | yes | declared required by the registry |

Registry hint (`params_hint`): op=status（默认，读群与脑清单）| op=convene & question=…（召开脑会，返回裁决与提案）

**注册表标注 `multi_op: true`，但没有枚举具体取值。**本包不替它编造取值清单——这种缺口应当在注册表源头补，而不是在文档里圆。

Types are deliberately absent: the registry does not declare them, and an invented
type is worse than no type, because callers believe it.

## Boundaries

- Not gated: the registry marks this bit `safe: true`.
- No external service dependency declared.
- Multi-op (`multi_op: true`): several sub-actions share one name — read `op` before calling.
- No implementation ships here. Bring a backend; the protocol is one method.

## What this is not

Not a wrapper around a hosted API. Not a model. Not a promise that calling it does
anything on its own. It is the typed seam plus the validation, which is the part that
stays correct even when the implementation changes.

## Tests

```bash
python -m pytest
```

```text
23 passed, 1 skipped in 0.12s
```

## Provenance

| field | value |
|---|---|
| capability | `brain_council` |
| domain | `mind` |
| handler | `brain_council` |
| safe | `True` (gated = `False`) |
| external | `False` |
| atlas page | [mind/brain_council](https://github.com/gbtweilai-star/gbt-caps/blob/main/caps/mind/brain_council.md) |
| full index | [https://github.com/gbtweilai-star/gbt-caps](https://github.com/gbtweilai-star/gbt-caps) |

The parent README says 348 capabilities; an AST pass over the registry enumerates
`341 + 0 unimplemented + 0 disabled = 341`. The extra 7 are historical duplicates.
Numbering here follows 341 and matches the `gbt-caps` index one-to-one.

## License

MIT.
